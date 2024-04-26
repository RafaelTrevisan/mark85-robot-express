*** Settings ***
Documentation    Ações e elementos da página de login

Library    Browser

*** Keywords ***
Submit login form
    [Arguments]    ${user}

    Fill Text    css=input[placeholder$=mail]    ${user}[email]    #O simbolo $ significar buscar um placeholder que TERMINE com "mail", encontrando assim o E-mail
    Fill Text    css=input[placeholder=Senha]    ${user}[password]
    
    Click        css=button >> text = Entrar