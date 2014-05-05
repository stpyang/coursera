package recfun
import Main._

object session {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet

  pascal(0, 2)                                    //> res0: Int = 1
  pascal(1, 2)                                    //> res1: Int = 2

  balance("(if (zero? x) max (/ 1 x))".toList)    //> res2: Boolean = true
	balance("I told him(that it's not (yet) done). (BUt he wasn't listening)".toList)
                                                  //> res3: Boolean = true
	balance(":-)".toList)                     //> res4: Boolean = false
	balance("())(".toList)                    //> res5: Boolean = false
	
	countChange(4, List(1,2))                 //> res6: Int = 3
}