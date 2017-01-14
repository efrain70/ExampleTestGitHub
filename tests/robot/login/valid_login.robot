*** Settings ***
Documentation    Testing valid login in Github with Email and username
Library          Selenium2Library

Suite Setup      Open Browser in Login Page
Test Teardown    Logout in Page and Go to Login
Suite Teardown   Close Browser

Test Template    Verify Login with valid Credentials

*** Variables ***
${USERNAME}=  efrain70
${EMAIL}=  efrain70@gmail.com
${PASSWORD}=  Mypass
${BROWSER}=  Firefox

*** Test Cases ***                     USERLOGIN      PASSWORD     NICK
Test Normal Login                      ${USERNAME}    ${PASSWORD}  ${USERNAME}
Test Login with email                  ${EMAIL}       ${PASSWORD}  ${USERNAME}

*** Keywords ***
Open Browser in Login Page
    Create webdriver  ${BROWSER}
    Go to Login

Verify Login with valid Credentials
    [arguments]  ${username}  ${password}  ${nick}
    Insert Username  ${username}
    Insert password  ${password}
    Submit Login form
    User Should be Logged As  ${nick}

Go to Login
    Go To   https://github.com/login
    Title Should be  Sign in to GitHub · GitHub

Insert Username
    [Arguments]  ${username}
    Input Text  id=login_field  ${username}

Insert Password
    [Arguments]  ${password}
    Input Password  id=password  ${password}

Submit Login form
    Submit Form  css=#login > form

User Should be Logged As
    [Arguments]  ${username}
    Open User Menu
    Page Should contain  Signed in as ${username}
    Open User Menu

Logout in Page and Go to Login
    Open User Menu
    Submit form    css=.logout-form
    Wait Until Page Does Not Contain Element  css=.avatar
    Go to Login

Open User Menu
    Wait until element is enabled  id=user-links
    Click Element  css=.name > .dropdown-caret
