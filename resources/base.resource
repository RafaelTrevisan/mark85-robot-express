*** Settings ***

Library    libs/database.py
Library    Browser
Library    JSONLibrary

Resource    env.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Header.resource
Resource    pages/components/Alert.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TasksPage.resource
Resource    services.resource

*** Keywords ***
Start Session
    New Browser     browser=chromium    headless=False
    New Page        ${BASE_URL}

#Helpers
Get fixtures
    [Arguments]    ${file_name}    ${scenario}
    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json    #Biblioteca para pegar um arquivo .json e seu diretório
    ...    encoding=utf-8                                     #Corrigir problema de acentuação bugada   
    # Log    ${data}[create][user]                            #Os colchetes separam os dados, nesse caso só puxou os dados do usuário
    
    RETURN    ${data}[${scenario}]

Reset user from database
    [Arguments]    ${user}

    Clean user from database     ${user}[email]
    Insert user from database    ${user}

Create a new task from aplicação
    [Arguments]    ${data}

    POST user session    ${data}[user]
    POST a new task      ${data}[task]

Do login
    [Arguments]    ${user}

    Submit login form          ${user}
    User shoub be logged in    ${user}[name]