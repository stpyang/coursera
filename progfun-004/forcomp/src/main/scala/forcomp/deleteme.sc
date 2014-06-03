package forcomp
import forcomp._

object deleteme {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  
   type Word = String
   type Sentence = List[Word]
   type Occurrences = List[(Char, Int)]
   val dictionary: List[Word] = loadDictionary    //> dictionary  : List[forcomp.deleteme.Word] = List(Aarhus, Aaron, Ababa, aback
                                                  //| , abaft, abandon, abandoned, abandoning, abandonment, abandons, abase, abase
                                                  //| d, abasement, abasements, abases, abash, abashed, abashes, abashing, abasing
                                                  //| , abate, abated, abatement, abatements, abater, abates, abating, Abba, abbe,
                                                  //|  abbey, abbeys, abbot, abbots, Abbott, abbreviate, abbreviated, abbreviates,
                                                  //|  abbreviating, abbreviation, abbreviations, Abby, abdomen, abdomens, abdomin
                                                  //| al, abduct, abducted, abduction, abductions, abductor, abductors, abducts, A
                                                  //| be, abed, Abel, Abelian, Abelson, Aberdeen, Abernathy, aberrant, aberration,
                                                  //|  aberrations, abet, abets, abetted, abetter, abetting, abeyance, abhor, abho
                                                  //| rred, abhorrent, abhorrer, abhorring, abhors, abide, abided, abides, abiding
                                                  //| , Abidjan, Abigail, Abilene, abilities, ability, abject, abjection, abjectio
                                                  //| ns, abjectly, abjectness, abjure, abjured, abjures, abjuring, ablate, ablate
                                                  //| d, ablates, ablating, ab
                                                  //| Output exceeds cutoff limit.
   def wordOccurrences(w: Word): Occurrences = w.groupBy(c => c.toLower).mapValues(_.length).toList.sortWith(_._1 < _._1)
                                                  //> wordOccurrences: (w: forcomp.deleteme.Word)forcomp.deleteme.Occurrences
   def sentenceOccurrences(s: Sentence): Occurrences = s match {
    case Nil => Nil
    case s => wordOccurrences(s.reduceLeft(_ + _))
  }                                               //> sentenceOccurrences: (s: forcomp.deleteme.Sentence)forcomp.deleteme.Occurren
                                                  //| ces
    lazy val dictionaryByOccurrences: Map[Occurrences, List[Word]] = dictionary.groupBy(wordOccurrences(_)).toMap
                                                  //> dictionaryByOccurrences: => Map[forcomp.deleteme.Occurrences,List[forcomp.de
                                                  //| leteme.Word]]
      def wordAnagrams(word: Word): List[Word] = dictionaryByOccurrences(wordOccurrences(word))
                                                  //> wordAnagrams: (word: forcomp.deleteme.Word)List[forcomp.deleteme.Word]
    def combinations(occurrences: Occurrences): List[Occurrences] = occurrences match {
   	case List() => List(List())
   	case (char, n) :: tail => {
   		for {
   			newHead <- (0 to n).map((char, _)).toList
   			newTail <- combinations(tail)
   		} yield (newHead :: newTail).filter(_._2 != 0)
   	 }
   }                                              //> combinations: (occurrences: forcomp.deleteme.Occurrences)List[forcomp.delet
                                                  //| eme.Occurrences]
    def subtract(x: Occurrences, y: Occurrences): Occurrences = {
    val yMap = y.foldLeft(Map[Char, Int]())((map, o) => map.updated(o._1.toLower, o._2))
    x.foldLeft(Map[Char, Int]())((map, o) => map.updated(o._1, o._2 - yMap.getOrElse(o._1.toLower, 0))).toList.filter(_._2 != 0)
  }                                               //> subtract: (x: forcomp.deleteme.Occurrences, y: forcomp.deleteme.Occurrences
                                                  //| )forcomp.deleteme.Occurrences
  
  dictionaryByOccurrences                         //> res0: Map[forcomp.deleteme.Occurrences,List[forcomp.deleteme.Word]] = Map(L
                                                  //| ist((e,1), (i,1), (l,1), (r,1), (t,2)) -> List(litter), List((a,1), (d,1), 
                                                  //| (e,1), (g,2), (l,1), (r,1)) -> List(gargled), List((a,1), (e,1), (h,1), (i,
                                                  //| 1), (k,1), (n,1), (s,3)) -> List(shakiness), List((e,2), (g,1), (n,1)) -> L
                                                  //| ist(gene), List((a,2), (n,1), (t,1), (y,1)) -> List(Tanya), List((a,1), (d,
                                                  //| 1), (e,2), (h,1), (m,1), (n,2), (o,1), (s,3)) -> List(handsomeness), List((
                                                  //| a,2), (c,1), (e,2), (k,1), (l,1), (m,1), (p,1), (r,1), (t,1)) -> List(marke
                                                  //| tplace), List((a,1), (i,1), (l,2), (s,1), (v,1)) -> List(villas), List((d,2
                                                  //| ), (e,1), (h,2), (n,1), (r,1), (t,1), (u,1)) -> List(hundredth), List((a,3)
                                                  //| , (b,1), (c,1), (h,1), (i,2), (l,1), (o,1), (p,2), (r,1), (t,1), (y,1)) -> 
                                                  //| List(approachability), List((d,1), (e,2), (l,1), (s,1), (t,2)) -> List(sett
                                                  //| led), List((a,1), (g,1), (i,3), (l,1), (n,2), (t,1), (z,1)) -> List(Latiniz
                                                  //| ing), List((a,1), (m,1)
                                                  //| Output exceeds cutoff limit.
  
       val test = List(('u',2), ('l',1), ('z',1)) //> test  : List[(Char, Int)] = List((u,2), (l,1), (z,1))
     dictionaryByOccurrences(test)                //> java.util.NoSuchElementException: key not found: List((u,2), (l,1), (z,1))
                                                  //| 	at scala.collection.MapLike$class.default(MapLike.scala:228)
                                                  //| 	at scala.collection.AbstractMap.default(Map.scala:58)
                                                  //| 	at scala.collection.MapLike$class.apply(MapLike.scala:141)
                                                  //| 	at scala.collection.AbstractMap.apply(Map.scala:58)
                                                  //| 	at forcomp.deleteme$$anonfun$main$1.apply$mcV$sp(forcomp.deleteme.scala:
                                                  //| 35)
                                                  //| 	at org.scalaide.worksheet.runtime.library.WorksheetSupport$$anonfun$$exe
                                                  //| cute$1.apply$mcV$sp(WorksheetSupport.scala:76)
                                                  //| 	at org.scalaide.worksheet.runtime.library.WorksheetSupport$.redirected(W
                                                  //| orksheetSupport.scala:65)
                                                  //| 	at org.scalaide.worksheet.runtime.library.WorksheetSupport$.$execute(Wor
                                                  //| ksheetSupport.scala:75)
                                                  //| 	at forcomp.deleteme$.main(forcomp.deleteme.scala:4)
                                                  //| 	at forcomp.deleteme.main(forcomp.deleteme.scala)
                                                 

     
}