*** Settings ***
Documentation    Cenários de cadastro de tarefas


Resource    ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastar uma nova tarefas
    
    ${data}    Get fixtures    tasks    create
    
    Reset user from database    ${data}[user]

    Do login    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]
    Task should be registered    ${data}[task][name]

Não deve cadastrar tarefa com nome duplicado
    [Tags]    dup
    ${data}    Get fixtures    tasks    duplicate

    #Dado que eu tenho um novo usuário
    Reset user from database    ${data}[user]

    #E que esse usuário ja cadastrou uma tarefa
    Create a new task from aplicação    ${data}

    #E que estou logado na aplicação web
    Do login    ${data}[user]

    #Quando faço um cadastro dessa mesma tarefa que ja foi cadastrada
    Go to task form
    Submit task form    ${data}[task]

    #então devo ver uma notificação de duplicidade
    Notice should be    Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]    tags_limit

    ${data}    Get fixtures    tasks    tags_limit

    Reset user from database    ${data}[user]

    Do login    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]

    Notice should be    Oops! Limite de tags atingido.
