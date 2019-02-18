#! env python

""" Main Python class for the trading application
@author: Laurent Winkler
@date: Feb 2019
@license: Boost
"""

import json

import PySide2.QtQml
from PySide2.QtCore import QObject, Signal, Slot, Property

from .JsonListModel import JsonListModel

class StockModel(QObject):

	def __init__(self, label, unitPrice, transactions):
		QObject.__init__(self)
		self.label = label
		self.unitPrice = unitPrice
		self._transactions = JsonListModel('type')
		for transaction in transactions:
			self._transactions.append(transaction)
		self.transactionsChanged.emit()
	
	@Slot(result=float)
	def amount(self):
		sum = 0
		for transaction in self._transactions.getList():
			sum += transaction['amount']
		return sum

	@Signal
	def transactionsChanged(self):
		pass

	def get_transactions(self, result=object):
		return self._transactions
	transactions = Property(QObject, get_transactions, notify = transactionsChanged)


class TradingClient(QObject):

	def __init__(self, stockListModel):
		QObject.__init__(self)
		self.stockListModel = stockListModel

	@Slot()
	def refreshStocks(self):
		""" Append all stocks """
		self.stockListModel.clear()

		self.stockListModel.append(StockModel("GOOGL", 1000.3, [
			{"date": "2018-02-02", "type": "buy", "amount": 4, "price": -4 * 980},
			{"date": "2019-01-08", "type": "sell", "amount": -2, "price": 2 * 1020}
		]))
		self.stockListModel.append(StockModel("AMZN", 1000.3, [
			{"date": "2018-02-02", "type": "buy", "amount": 40, "price": 40 * 760},
			{"date": "2019-01-08", "type": "sell", "amount": 22, "price": 22 * 783}
		]))


	@Slot(str, str, str)
	def uploadSubjectByIndex(self, projectIndex, patientPath, anonymizationDataJson):
		""" Upload a subject to Trading from a directory """
		pass

