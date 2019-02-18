#! env python

""" Simple model for a list of objects
@author: Laurent Winkler
@date: Feb 2019
@license: Boost
"""

import json
from PySide2.QtCore import QAbstractListModel, Qt

class StockListModel(QAbstractListModel):
	""" A simple model for a list of object for QML. Each item is a JSON object """

	ObjectRole = Qt.UserRole + 1
	JsonRole   = Qt.UserRole + 2
	TransactionsRole = Qt.UserRole + 3

	def __init__(self, displayTag = "name", parent = None):
		self.displayTag = displayTag
		QAbstractListModel.__init__(self, parent)
		self._objects = []

	def roleNames(self):
		roles = super().roleNames()
		roles[self.ObjectRole] = b"object"
		roles[self.JsonRole] = b"json"
		roles[self.TransactionsRole] = b"transactions"
		roles[self.TransactionsRole + 1] = b"label"
		return roles

	def rowCount(self, index):
		""" Return the number of rows (required by QML) """
		return len(self._objects)

	def data(self, index, role):
		""" Return a label to display one element (required by QML) """
		if not index.isValid():
			return None

		if index.row() > len(self._objects):
			return None

		obj = self._objects[index.row()]
		if role == self.ObjectRole:
			return obj
		if role == self.JsonRole:
			# note: output of this will only be similar to JSON
			return str(obj.__dict__)

		rnames = self.roleNames()
		if role not in rnames:
			raise Exception('Unknown role')
		roleStr = rnames[role].decode('ascii')
		if getattr(obj, roleStr, None):
			return getattr(obj, roleStr, None)
		return obj.label

	def get(self, index):
		""" Return the nth element """
		return None if index > len(self._objects) else self._objects[index]

	def getList(self):
		return self._objects

	def setList(self, objects):
		""" Override the list of objects """
		if self._objects == objects:
			return
		oldLength = len(self._objects)
		self._objects = objects
		self.rowsRemoved.emit(self, 0, oldLength - 1)
		self.rowsInserted.emit(self, 0, len(objects) - 1)

	def clear(self):
		""" Clear the list of objects """
		oldLength = len(self._objects)
		self._objects = []
		# Note: untested
		self.rowsRemoved.emit(self, 0, oldLength - 1)

	def append(self, obj):
		""" Append an object to the list of objects """
		self._objects.append(obj)
		# Note: untested
		self.rowsInserted.emit(self, len(self._objects) - 1, len(self._objects) - 1)

