import pytest

from selenium import webdriver


@pytest.fixture(scope='module')
def browser(request):
    """Fixture, open a firefox browser.

    Return a firefox browser and finalize it
    with a closing-quitting
    """
    driver = webdriver.Firefox()

    def close_quit():
        """Close and quit the opened browser."""
        driver.close()
        driver.quit()

    request.addfinalizer(close_quit)
    return driver

