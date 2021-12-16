from breezypythongui import EasyFrame

class VerbConjugator(EasyFrame):

    def __init__(self):
        """Sets up the window and widgets."""
        EasyFrame.__init__(self, title = "Japanese Verb Conjugator", height = 400, width = 1040)

        # Create a ListBox object
        self.listBox = self.addListbox(row = 0, column = 0, rowspan = 50, width = 5)
        
        # Add the list of verbs to the ListBox
        self.listBox.insert(0, "Apologize / Ayamaru")
        self.listBox.insert(1, "Break / Waru")
        self.listBox.insert(2, "Build / Tateru")
        self.listBox.insert(3, "Burn / Kogeru ")
        self.listBox.insert(4, "Buy / Kau")
        self.listBox.insert(5, "Cause / Hikiokosu")
        self.listBox.insert(6, "Climb / Agaru")
        self.listBox.insert(7, "Come / Kuru")
        self.listBox.insert(8, "Decorate / Oyogu")
        self.listBox.insert(9, "Dedicate / Sasageru")
        self.listBox.insert(10, "Delete / Kesu")
        self.listBox.insert(11, "Die / Shinu")
        self.listBox.insert(12, "Dream / Yumemiru")
        self.listBox.insert(13, "Drink / Nomu")
        self.listBox.insert(14, "Eat / Taberu")
        self.listBox.insert(15, "Fall / Ochiru")
        self.listBox.insert(16, "Go / Iku")
        self.listBox.insert(17, "Grow / Sodatsu")
        self.listBox.insert(18, "Investigate / Shiraberu")
        self.listBox.insert(19, "Jump / Tobu")
        self.listBox.insert(20, "Kill / Korosu")
        self.listBox.insert(21, "Know / Shiru")
        self.listBox.insert(22, "Look / Miru")
        self.listBox.insert(23, "Punch / Naguru")
        self.listBox.insert(24, "Push / Osu")
        self.listBox.insert(25, "Reach / Oyobu")
        self.listBox.insert(26, "Read / Yomu")
        self.listBox.insert(27, "Realize / Satoru")
        self.listBox.insert(28, "Remember Omoidasu")
        self.listBox.insert(29, "Return / Kaeru")
        self.listBox.insert(30, "Run / Hashiru")
        self.listBox.insert(31, "Scare / Kowagaraseru")
        self.listBox.insert(32, "Scream / Sakebu")
        self.listBox.insert(33, "Search / Sagasu")
        self.listBox.insert(34, "Sell / Uru")
        self.listBox.insert(35, "Shoot / Utsu")
        self.listBox.insert(36, "Show / Miseru")
        self.listBox.insert(37, "Shrink / Chijimu")
        self.listBox.insert(38, "Sing / Utau")
        self.listBox.insert(39, "Sleep / Nemuru")
        self.listBox.insert(40, "Speak / Hanasu")
        self.listBox.insert(41, "Spin / Mawasu")
        self.listBox.insert(42, "Stab / Tsukisasu")
        self.listBox.insert(43, "Steal / Nusumu")
        self.listBox.insert(44, "Threaten / Odosu")
        self.listBox.insert(45, "Throw / Nageru")
        self.listBox.insert(46, "Understand / Wakaru")
        self.listBox.insert(47, "Wait / Matsu")
        self.listBox.insert(48, "Walk / Aruku")
        self.listBox.insert(49, "Write / Kaku")
        
        # Add the check buttons for time tense (past or present)
        self.addLabel(text = "Time", row = 0, column = 1)
        self.pastCB = self.addCheckbutton(text = "Past (Was)", row = 0, column = 2)
        self.presentCB = self.addCheckbutton(text = "Present (Is)", row = 0, column = 3)

        # Add the check buttons for verb tense (simple, continuous, negative, conditional)
        self.addLabel(text = "Tense", row = 2, column = 1)
        self.simpleCB = self.addCheckbutton(text = "Simple (Is/Am/Are)", row = 2, column = 2)
        self.continuousCB = self.addCheckbutton(text = "Continuous (Is doing)", row = 2, column = 3)
        self.negativeCB = self.addCheckbutton(text = "Negative (Is not)", row = 2, column = 4)
        self.conditionalCB = self.addCheckbutton(text = "Conditional (If it is)", row = 2, column = 5)

        # Add the button to conjugate
        self.addButton(text = "Conjugate!", row = 4, column = 1, command = self.conjugate)

        # Add the text field to output the conjugated verb
        self.outputField = self.addTextField(text = "", row = 4, column = 2, width = 25, state = "readonly")

        # The method for conjugating the verb
    def conjugate(self):
        """Conjugates the selected verb"""
        
        # A variable for holding the selected verb is initialized
        verb = self.listBox.getSelectedItem()  
        if self.pastCB.isChecked():

                #tsu ending group
            if verb[-3:] == "tsu":
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('tsu', 'chimashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('tsu', 'tteimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('tsu', 'chimasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('tsu', 'chimashitara'))
                            
                #ru ending group           
            elif verb[-2:] == "ru":
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('ru', 'rimashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('ru', 'tteimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('ru', 'rimasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('ru', 'rimashitara'))

                #mu ending group       
            elif verb[-2:] == "mu":
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('mu', 'mimashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('mu', 'ndeimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('mu', 'mimasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('mu', 'mimashitara'))

                #bu ending group       
            elif verb[-2:] == "bu":
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('bu', 'bimashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('bu', 'ndeimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('bu', 'bimasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('bu', 'bimashitara'))

                #nu ending group       
            elif verb[-2:] == "nu":
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('nu', 'nimashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('nu', 'ndeimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('nu', 'nimasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('nu', 'nimashitara'))

                #ku ending group       
            elif verb[-2:] == "ku":
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('ku', 'kimashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('ku', 'iteimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('ku', 'kimasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('ku', 'kimashitara'))

                #gu ending group       
            elif verb[-2:] == "gu":
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('gu', 'gimashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('gu', 'ideimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('gu', 'gimasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('gu', 'gimashitara'))

                #su ending group       
            elif verb[-2:] == "su":
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('su', 'shimashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('su', 'shiteimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('su', 'shimasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('su', 'shimashitara'))

                #u ending group       
            else:
                    if self.simpleCB.isChecked():
                        self.outputField.setText(verb.replace('u', 'imashita'))
                    elif self.continuousCB.isChecked():
                        self.outputField.setText(verb.replace('u', 'tteimashita'))
                    elif self.negativeCB.isChecked():
                        self.outputField.setText(verb.replace('u', 'imasendeshita'))
                    elif self.conditionalCB.isChecked():
                        self.outputField.setText(verb.replace('u', 'imashitara'))
                
        elif self.presentCB.isChecked():

                    #tsu ending group
                if verb[-3:] == "tsu":
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('tsu', 'chimasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('tsu', 'tteimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('tsu', 'chimasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('tsu', 'teba'))

                    #ru ending group
                elif verb[-2:] == "ru":
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('ru', 'rimasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('ru', 'tteimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('ru', 'rimasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('ru', 'reba'))
                        
                    #mu ending group
                elif verb[-2:] == "mu":
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('mu', 'mimasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('mu', 'ndeimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('mu', 'mimasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('mu', 'meba'))
                            
                    #bu ending group   
                elif verb[-2:] == "bu":
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('bu', 'bimasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('bu', 'ndeimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('bu', 'bimasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('bu', 'beba'))
                    
                    #nu ending group
                elif verb[-2:] == "nu":
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('nu', 'nimasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('nu', 'ndeimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('nu', 'nimasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('nu', 'neba'))
                        
                    #ku ending group
                elif verb[-2:] == "ku":
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('ku', 'kimasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('ku', 'iteimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('ku', 'kimasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('ku', 'keba'))
                    
                    #gu ending group
                elif verb[-2:] == "gu":
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('gu', 'gimasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('gu', 'ideimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('gu', 'gimasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('gu', 'geba'))
                    
                    #su ending group
                elif verb[-2:] == "su":
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('su', 'shimasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('su', 'shiteimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('su', 'shimasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('su', 'seba'))
                    
                    #u ending group
                else:
                        if self.simpleCB.isChecked():
                            self.outputField.setText(verb.replace('u', 'imasu'))
                        elif self.continuousCB.isChecked():
                            self.outputField.setText(verb.replace('u', 'tteimasu'))
                        elif self.negativeCB.isChecked():
                            self.outputField.setText(verb.replace('u', 'imasen'))
                        elif self.conditionalCB.isChecked():
                            self.outputField.setText(verb.replace('u', 'eba'))
                            
        self.messageBox(title = "Success", message = "Conjugation complete")

def main():
    VerbConjugator().mainloop()

if __name__ == "__main__":
    main()
