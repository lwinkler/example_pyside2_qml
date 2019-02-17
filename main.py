#! env python

""" Python main, instanciate all objects """
__author__      = "Laurent Winkler"
__copyright__   = "Copyright 2019"
__license__     = "boost"


import os
import sys
from optparse import OptionParser

from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtQml import QQmlApplicationEngine

from lib.py.JsonListModel import JsonListModel
from lib.py.TradingClient import TradingClient

# Options
parser = OptionParser(usage="usage: %prog [options]", version="%prog 1.0")
parser.add_option("-I", "--stock-list", action = "store", dest = "stockList", default = None, help = "List of stocks in JSON format")

# arguments for QApplication
parser.add_option("--style", help = "Passed to the constructor of QApplication")
(options, args) = parser.parse_args()

if len(args) != 0:
	parser.error("Wrong number of arguments. Use %s --help" % sys.argv[0])

# Company name: this avoids an error message
QGuiApplication.setOrganizationName("MyCompany")
QGuiApplication.setOrganizationDomain("mycompany.com")

# View model
stockListModel  = JsonListModel(displayTag = "label")

# Python objects
tradingClient = TradingClient(stockListModel)

# Main
if __name__ == '__main__':
	
	# Setup the application window, by default use google material style
	if '--style' not in sys.argv:
		sys.argv += ['--style', 'material']
	sys.argv += ['--qwindowtitle', 'Example of trading client in QML+Python']
	app = QGuiApplication(sys.argv)
	# TODO app.setWindowIcon(QIcon('tradingClient.ico'))
	engine = QQmlApplicationEngine()

	# Set models used by QML files
	engine.rootContext().setContextProperty('pyStockListModel', stockListModel)
	engine.rootContext().setContextProperty('pyTradingClient', tradingClient)

	engine.load('lib/qml/TradingClient.qml')

	app.exec_()
