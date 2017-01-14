*** Settings ***
Documentation    Testing valid login in Github with Email and username
Library          Selenium2Library
Resource         ./common_login.robot

Test Teardown    Logout in Page and Go to Login

Test Template    Verify Login with valid Credentials

*** Variables ***
${USERNAME}=  efrain70
${EMAIL}=  efrain70@gmail.com
${PASSWORD}=  Mypass

*** Test Cases ***       USERLOGIN      PASSWORD     NICK
Test Normal Login        ${USERNAME}    ${PASSWORD}  ${USERNAME}
Test Login with email    ${EMAIL}       ${PASSWORD}  ${USERNAME}

*** Keywords ***

Verify Login with valid Credentials
    [Documentation]  Verify the login process with a
    ...  given usernane, password and nick
    [Arguments]  ${username}  ${password}  ${nick}
    Insert Username  ${username}
    Insert password  ${password}
    Submit Login form
    User Should be Logged As  ${nick}

User Should be Logged As
    [Documentation]  Verify the user is logged with a given nick
    [Arguments]  ${username}
    Open User Menu
    Page Should contain  Signed in as ${username}
    Open User Menu

Logout in Page and Go to Login
    [Documentation]  Logout the user and go to login page
    Open User Menu
    Submit form    css=.logout-form
    Wait Until Page Does Not Contain Element  css=.avatar
    Go To   https://github.com/login

Open User Menu
    [Documentation]  Open the user menu (dropdown)
    Wait until element is enabled  id=user-links
    Click Element  css=.name > .dropdown-caret
