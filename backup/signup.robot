*** Settings ***
Documentation        Cenários de testes do cadastro de usuário

Resource    ../resources/base.resource

Suite Setup        Log    Tudo aqui ocorre antes da suíte (Antes de todos os testes)
Suite Teardown     Log    Tudo aqui ocorre depois da suíte (Depois de todos os testes)

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${user}    Create Dictionary    
    ...    name=Rafael Trevisan    
    ...    email=rafael@hotmail.com    
    ...    password=rafa102030  

    Remove user from database    ${user}[email]

    Go to signup page
    Submit signup form    ${user}
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}    Create Dictionary    
    ...    name=Trevisan Rafael    
    ...    email=rafael@gmail.com    
    ...    password=rafa102030

    Remove user from database    ${user}[email]    
    Insert user from database    ${user}

    Go to signup page
    Submit signup form    ${user}
    Notice should be     Oops! Já existe uma conta com o e-mail informado.

Campos Obrigatórios
    [Tags]    required

    ${user}    Create Dictionary    
    ...        name=${EMPTY}
    ...        email=${EMPTY}
    ...        password=${EMPTY}

    Go to signup page
    Submit signup form    ${user}
    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email   
    Alert should be    Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com senha muito curta
    [Tags]    temp

    # @ = Lista de informações
    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}     #Para cada SENHA da LISTA de SENHAS faça:
         ${user}    Create Dictionary                #Crie uma super variável contendo os seguintes dados
        ...        name=Rafael Trevisan
        ...        email=rafael@hotmail.com
        ...        password=${password}              #A senha será os dados que foram incluidos na linha 58

        Go to signup page
        Submit signup form    ${user}
        Alert should be    Informe uma senha com pelo menos 6 digitos
        
    END

Não deve cadastrar com email incorreto
    [Tags]    inv_email
    ${user}    Create Dictionary    
    ...    name=Charles Xavier    
    ...    email=xavier.com.br    
    ...    password=123456

    Go to signup page
    Submit signup form    ${user}
    Alert should be    Digite um e-mail válido

Não deve cadastrar com senha de 1 digito
     [Tags]    short_pass
     [Template]
     Short password    1

Não deve cadastrar com senha de 2 digitos
     [Tags]    short_pass
     [Template]
     Short password    12

Não deve cadastrar com senha de 3 digitos
     [Tags]    short_pass
     [Template]
     Short password    123

Não deve cadastrar com senha de 4 digitos
     [Tags]    short_pass
     [Template]
     Short password    1234

Não deve cadastrar com senha de 5 digitos
     [Tags]    short_pass
     [Template]
     Short password    12345

   
*** Keywords ***
Short password
    [Arguments]    ${short_pass}

      ${user}    Create Dictionary               
        ...        name=Rafael Trevisan
        ...        email=rafael@hotmail.com
        ...        password=${short_pass}          

        Go to signup page
        Submit signup form    ${user}
        Alert should be    Informe uma senha com pelo menos 6 digitos
