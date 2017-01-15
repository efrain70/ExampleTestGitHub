# ExampleTestGitHub

## Installation with pip from repository
```shell
pip install git+https://github.com/efrain70/ExampleTestGitHub.git
```

## How to use it

### With Tox

```shell
tox -e robot
```

```shell
tox -e pytest
```


### Command line

- RobotFramework script (Firefox, default)
```shell
pybot -v BROWSER:Firefox tests/robot/login
```

- RobotFramework script (Chrome)
```shell
pybot -v BROWSER:Chrome tests/robot/login
```

- Pytest (only support Firefox)
```shell
pytest -v tests/pytest/login
```

## Limitations
- Currently is implemented examples of testing the Login flow.
- GitHub protects against attacts the Login system. You may get a 'too many failed attempts' error.
- Pytest only tests with Firefox.

## TODOs
- Add new examples of invalid credentials.
- Support of Chrome, Opera, PhantonJS browsers in Pytest
- Add new Test cases for Login

## Next features
- Testing the Registration flow