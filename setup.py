from setuptools import setup, find_packages

setup(
    name='example-github',
    version='0.1.0',
    description='An example how to test Github with '
                'Robot Framework and Py.test',

    url='https://github.com/efrain70/ExampleTestGitHub',

    author='Efrain Lima Miranda',
    author_email='efrain70@gmail.com',

    license='GPL-3.0',

    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GPL-3.0 License',
        'Framework :: Robot Framework',
        'Framework :: Pytest',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
    ],

    keywords='testing github robotframework pytest selenium',

    packages=find_packages(),

    install_requires=[
        'pytest',
        'robotframework-selenium2library'
    ],
)
