import pytest

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec


USERNAME = 'efrain70'
EMAIL = 'efrain70@gmail.com'
PASSWORD = 'My pass'


@pytest.fixture()
def browser_in_login(request, browser):
    """Fixture. Go to the login page.

    When finalizes, forces the browser to go
    again to the login page.
    """
    login_url = 'https://github.com/login'

    browser.get(login_url)

    def go_to_login():
        browser.get(login_url)

    request.addfinalizer(go_to_login)
    return browser


@pytest.fixture()
def browser_to_logout(request, browser_in_login):
    """Fixture. Go to the login page.

    When finalizes, forces the browser to go
    to the logout page and submit the logout form.
    """
    logout_url = 'https://github.com/logout'

    def logout():
        browser_in_login.visit(logout_url)
        form_logout = browser_in_login.find_element_by_tag_name('form')
        form_logout.submit()

    request.addfinalizer(logout)

    return browser_in_login


class TestLogin(object):
    """
    Test suite for login page in GitHub
    """

    error_message = 'Incorrect username or password.'
    username_field = 'login_field'
    password_field = 'password'
    submit_form = '#login > form'
    error_container = ".flash-error > .container"
    user_options = '.name > .dropdown-caret'
    user_header = 'header-nav-current-user'

    def insert_username(self, browser, username):
        """Insert the username in the login page."""
        username_element = browser.find_element_by_id(
            self.username_field)
        username_element.send_keys(username)

    def insert_password(self, browser, password):
        """Insert the password in the login page."""
        password_element = browser.find_element_by_id(
            self.password_field)
        password_element.send_keys(password)

    def submit_login_form(self, browser):
        """Submit the login form."""
        submit_form = browser.find_element_by_css_selector(
            self.submit_form)
        submit_form.submit()

    def send_credentials(self, browser, username, password):
        """Send the credentials."""
        self.insert_username(browser, username)
        self.insert_password(browser, password)
        self.submit_login_form(browser)

    def get_message_displayed(self, browser):
        """Get The message displayed in the login."""
        element = WebDriverWait(browser, 10).until(
            ec.presence_of_element_located(
                (By.CSS_SELecTOR, self.error_container))
        )
        return element.text

    def user_logged(self, browser):
        """Get the header text from the logged user's options."""
        user_menu = WebDriverWait(browser, 10).until(
            ec.visibility_of_element_located(
                (By.CSS_SELecTOR, self.user_options))
        )
        user_menu.click()

        user_name = WebDriverWait(browser, 10).until(
            ec.visibility_of_element_located(
                (By.CLASS_NAME, self.user_header))
        )

        return user_name.text

    @pytest.mark.parametrize(('username', 'password'), [
        ('NoUserThisName', PASSWORD),
        (USERNAME, 'Bad password'),
        ('', PASSWORD),
        (USERNAME, ''),
        ('', ''),
        (USERNAME, PASSWORD + ' '),
    ])
    def test_invalid(self, username, password, browser_in_login):
        """
        Test invalid credentials in the GitHub login page.
        :param username: username
        :param password: password
        :param browser_in_login: browser in login page
        """
        self.send_credentials(browser_in_login, username, password)
        message = self.get_message_displayed(browser_in_login)
        assert message == self.error_message

    @pytest.mark.parametrize(('username', 'password'), [
        (USERNAME, PASSWORD),
        (USERNAME + ' ', PASSWORD),
        (EMAIL, PASSWORD),
        (EMAIL + ' ', PASSWORD),
    ])
    def test_valid(self, username, password, browser_to_logout):
        """
        Test valid credentials in the GitHub login page.
        :param username: username
        :param password: password
        :param browser_in_login: browser in login page, logout when fin
        """
        self.send_credentials(browser_to_logout, username, password)
        user_text = self.user_logged(browser_to_logout)
        assert user_text == 'Signed in as %s' % USERNAME
