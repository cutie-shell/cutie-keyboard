import QtQuick

Item {
	property var row1_model: row1
	property var row1_model_shift: row1_shift
	property var row1B_model: row1B

	property var row2_model: row2
	property var row2B_model: row2B 

	property var row3_model: row3 
	property var row3B_model: row3B 

	property var row4_model: row4
	property var row4B_model: row4B
	
	property var row5_model: row5
	property var row5_model_shift: row5_shift

	property var layout: 'Dial'

	ListModel {
		id: row1
		ListElement{displayText: '1'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '2'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '3'; keyWidth: 2.3; capitalization: false;}
	}

	ListModel {
		id: row1_shift
	}

	ListModel {
		id: row1B
	}

	ListModel {
		id: row2
		ListElement{displayText: '4'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '5'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '6'; keyWidth: 2.3; capitalization: false;}
	}

	ListModel {
		id: row2B
	}

	ListModel {
		id: row3
		ListElement{displayText: '7'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '8'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '9'; keyWidth: 2.3; capitalization: false;}
	}

	ListModel {
		id: row3B
	}

	ListModel {
		id: row4
		ListElement{displayText: '*'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '0'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '#'; keyWidth: 2.3; capitalization: false;}
		
	}

	ListModel {
		id: row4B
		
	}

	ListModel {
		id: row5
		ListElement{displayText: '+'; keyWidth: 2.3; capitalization: false;}
		ListElement{displayText: '\u21E6'; keyWidth: 4.6; capitalization: false;}
	}

	ListModel {
		id: row5_shift
	}
}