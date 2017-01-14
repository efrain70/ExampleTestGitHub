*** Settings ***
Library  Selenium2Library
Suite Setup      Open Browser in Login Page
Suite Teardown   Close Browser

*** Variables ***
${BROWSER}=  Firefox

*** Keywords ***
Open Browser in Login Page
    [Documentation]  Open the browser and
    ...  go to the login page of Github
    Create webdriver  ${BROWSER}
    Go To   https://github.com/login
