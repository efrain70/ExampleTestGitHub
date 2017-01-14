*** Settings ***
Documentation    Testing invalid login in Github
Library          Selenium2Library
Resource         ./common_login.robot

Test Teardown    Go to login again
Test Template    Verify Login with invalid Credentials
Default Tags     Invalid

*** Variables ***
${LOGIN ERROR}=  Incorrect username or password.
${MESSAGE ELEMENT}=  css=.flash-error > .container

*** Test Cases ***        USERLOGIN            PASSWORD
Test Wrong username       NoUserThisName       ${PASSWORD}
Test Wrong pass           ${USERNAME}          Bad Password
Test Empty username       ${EMPTY}             ${PASSWORD}
Test Empty pass           ${USERNAME}          ${EMPTY}
Test Empty credentials    ${EMPTY}             ${EMPTY}
Test Username + Space     ${USERNAME}${SPACE}  ${PASSWORD}
Test Password + Space     ${USERNAME}          ${PASSWORD}${SPACE}

*** Keywords ***

Verify login with invalid Credentials
    [Documentation]  Verify the login process fail with a
    ...  given usernane, password
    [Arguments]  ${username}  ${password}
    Insert Username  ${username}
    Insert password  ${password}
    Submit Login form
    Login Error Should be Displayed


Login Error Should be Displayed
    [Documentation]  Verify an login error message is shown
    Wait Until Element Is Visible  ${MESSAGE ELEMENT}
    Element Should Contain  ${MESSAGE ELEMENT}  ${LOGIN ERROR}

Go to login again
    [Documentation]  Force to go to login page
    Go To   https://github.com/login
