test:
	mocha -R tap --compilers coffee:coffee-script/register test_*.coffee

land:
	mocha -R landing --compilers coffee:coffee-script/register test_*.coffee
