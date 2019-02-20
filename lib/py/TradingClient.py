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

	def __init__(self, symbol, unitPrice, transactions):
		QObject.__init__(self)
		self._symbol = symbol
		self.unitPrice = unitPrice
		self._transactions = JsonListModel('type')
		for transaction in transactions:
			self._transactions.append(transaction)
		self.valueChanged.emit()
	

	@Signal
	def valueChanged(self):
		pass

	def getLabel(self):
		return self._symbol
	symbol = Property(str, getLabel, notify = valueChanged)

	def getTransactions(self):
		return self._transactions
	# trick: to use a custom object as a property, use QObject !
	transactions = Property(QObject, getTransactions, notify = valueChanged)

	def getAmount(self):
		sum = 0
		for transaction in self._transactions.getList():
			sum += transaction['amount']
		return sum
	amount = Property(int, getAmount, notify = valueChanged)


class TradingClient(QObject):

	def __init__(self, stockListModel):
		QObject.__init__(self)
		self.stockListModel = stockListModel

	@Slot()
	def resetStocks(self):
		""" Append all stocks """
		self.stockListModel.clear()

		self.stockListModel.append(StockModel("GOOGL", 1000.3, [
			{"date": "2018-02-02", "type": "buy", "amount": 4, "price": -4 * 980},
			{"date": "2019-01-08", "type": "sell", "amount": -2, "price": 2 * 1020}
		]))
		self.stockListModel.append(StockModel("AMZN", 1208.2, [
			{"date": "2018-02-02", "type": "buy", "amount": 40, "price": -40 * 760},
			{"date": "2019-01-08", "type": "sell", "amount": -22, "price": 22 * 783}
		]))


	@Slot(str, str, str)
	def uploadSubjectByIndex(self, projectIndex, patientPath, anonymizationDataJson):
		""" Upload a subject to Trading from a directory """
		pass
	
	@Slot(QObject, str, str, str, int)
	def addTransaction(self, stockList, symbol, dateStr, typeStr, amount):
		price = 9999 # TODO
		if typeStr == 'buy':
			price = -price
		elif typeStr == 'sell':
			amount = -amount
		else:
			raise Exception('Unknown transaction type ' + typeStr)
		for stock in stockList.getList():
			if stock.symbol == symbol:
				stock._transactions.append({"date": dateStr, "type": typeStr, "amount": amount, "price": price})
				return
		stockList.append(StockModel(symbol, 9999, [
			{"date": dateStr, "type": typeStr, "amount": amount, "price": amount * 9999}
		])) # TODO
 
