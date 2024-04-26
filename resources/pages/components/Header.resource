*** Settings ***   
Documentation    Ações e elementos do cabeçalho do Mark85

Library    Browser
Library    String

*** Keywords ***
User shoub be logged in
    [Arguments]    ${name}

    @{splited_name}    Split String    ${name}    #Criou uma lista de nome, a função Split strig é um separador de stings, assim ele pegou a variável name = [Rafael], [Trevisan]

    ${element}    Set Variable    css=header .right small
    Wait For Elements State    ${element}    visible    5
    Get Text    ${element}    equal    Olá, ${splited_name}[0]    #Aqui ele ta pegando o texto, onde o splited_name é a lista de strings e o [0] é a primeira informação da lista, sendo "Rafael"

Go to task form
    Click    css=.button-add