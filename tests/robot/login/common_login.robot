*** Settings ***
Documentation    Suite description
Library          Selenium2Library

*** Variables ***
${USERNAME}=  efrain70
${EMAIL}=  efrain70@gmail.com
${PASSWORD}=  Mypass

*** Keywords ***
Insert Username
    [Documentation]  Introduce a given username in the login form
    [Arguments]  ${username}
    Input Text  id=login_field  ${username}

Insert Password
    [Documentation]  Introduce a given password in the login form
    [Arguments]  ${password}
    Input Password  id=password  ${password}

Submit Login form
    [Documentation]  Submit the login form
    Submit Form  css=#login > form