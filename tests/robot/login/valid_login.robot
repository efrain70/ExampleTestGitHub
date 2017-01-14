*** Settings ***
Documentation    Testing valid login in Github with Email and username
Library          Selenium2Library
Resource         ./common_login.robot
Default Tags     valid

Test Teardown    Logout in Page and Go to Login

Test Template    Verify Login with valid Credentials

*** Variables ***
${USER MENU ELEMENT}=  css=.name > .dropdown-caret
${AVATAR ELEMENT}=  css=.avatar
${LOGOUT FORM}=  css=.logout-form

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
    Submit form    ${LOGOUT FORM}
    Wait Until Page Does Not Contain Element  ${AVATAR ELEMENT}
    Go To   https://github.com/login

Open User Menu
    [Documentation]  Open the user menu (dropdown)
    Wait until element is enabled  id=user-links
    Click Element  ${USER MENU ELEMENT}
