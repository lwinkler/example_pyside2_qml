// Copyright (c) 2019 Laurent Winkler
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

/// Return the path from a file:/// url
function fileURLToPath(url) {
	var path = url.replace('file://', '');
	if(path.length >= 3 && path[0] === '/' && path[2] === ':') {
		// Windows path
		path = path.substr(1);
	}
	return path;
}

function getDateStr() {
	var d = new Date();
	return "" + d.getFullYear() + d.getMonth() + d.getDay();
}

function getMethods(obj) {
	var result = [];
	for (var id in obj) {
		console.log("* " + id); // + ": " + obj[id].toString());
	}
	return result;
}

function limitString(str, size) {
	return str.length > size ? str.substring(0, size - 1) + '\n...' : str;
}

function pad(num, size) {
	var s = num+"";
	while (s.length < size) s = "0" + s;
	return s;
}

function dateNow() {
	var d = new Date();
	return d.getFullYear() + '-' + pad(d.getMonth(), 2) + '-' + pad(d.getDay(), 2);
}
