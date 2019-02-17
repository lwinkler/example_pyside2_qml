#! env python

""" Main Python class for the trading application
@author: Laurent Winkler
@date: Feb 2019
@license: Boost
"""

import datetime
import json

import PySide2.QtQml
from PySide2.QtCore import QObject, Signal, Slot, Property

from .JsonListModel import JsonListModel

class StockModel(QObject):

	def __init__(self, label, unitPrice):
		QObject.__init__(self)
		self.label = label
		self.unitPrice = unitPrice
		self._transactions = JsonListModel('label')
		self._transactions.append({"label": "trans2"})
		self._transactions.append({"label": "trans3"})
		self._transactions.append({"label": "trans4"})
		self._transactions.append({"label": "trans5"})
		self.transactionsChanged.emit()
	
	@Signal
	def transactionsChanged(self):
		pass
	
	def get_transactions(self, result=object):
		return self._transactions
	transactions = Property(object, get_transactions, notify = transactionsChanged)


class TradingClient(QObject):

	def __init__(self, stockListModel):
		QObject.__init__(self)
		self.stockListModel = stockListModel

	@Slot(str, str, result=str)
	def proposeAnonymizedValue(self, dicomTag, dicomDataStr):
		""" Propose an anonymized value for the DICOM tag """
		# TODO adapt

		return "NONE"

	@Slot()
	def refreshStocks(self):
		""" Append all stocks """
		self.stockListModel.clear()

		self.stockListModel.append(StockModel("GOOGL", 1000.3))
		self.stockListModel.append(StockModel("AMZN", 1000.3))

		return
		self.stockListModel.append({"symbol": "GOOGL", "amount": 2, "unitPrice": 1200.01, "transactions": [
			 {"amount": 2}
		]})
		self.stockListModel.append({"symbol": "AMZN", "amount": 4, "unitPrice": 1303.01, "transactions": [
			 {"amount": 2},
			 {"amount": 2},
			 {"amount": 2},
			 {"amount": 2}
		]})


	@Slot(str, str, str)
	def uploadSubjectByIndex(self, projectIndex, patientPath, anonymizationDataJson):
		""" Upload a subject to Trading from a directory """
		pass

