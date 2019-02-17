#! env python

""" Main Python class for the trading application """
__author__      = "Laurent Winkler"
__copyright__   = "Copyright 2019"
__license__     = "boost"

import datetime
import json

import PySide2.QtQml
from PySide2.QtCore import QObject, Signal, Slot, Property

from .JsonListModel import JsonListModel

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
	def updateProjectList(self):
		""" Fetch project list and add it to model """
		# TODO read from JSON
		pass


	@Slot(str, str, str)
	def uploadSubjectByIndex(self, projectIndex, patientPath, anonymizationDataJson):
		""" Upload a subject to Trading from a directory """
		pass

