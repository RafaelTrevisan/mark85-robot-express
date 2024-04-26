*** Settings ***
Documentation    Cenários de testes de atualização de tarefas

Resource    ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder marcar uma tarefa como concluida

    ${data}    Get fixtures    tasks    done

    Reset user from database    ${data}[user]

    Create a new task from aplicação    ${data}

    Do login    ${data}[user]

    Mark task as completed     ${data}[task][name]
    Task should be complete    ${data}[task][name]
    