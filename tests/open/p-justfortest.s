
main {
   fdef alice () {
     return 5;
   } : int;

    s1:string := "Alice in Wonderland";
    
	alias seq<char> string;
	alias fred spud;
	tdef person { name:string, surname:string, age:int };
	tdef family { mother:person, father:person, children:seq<person> };
	return;
};
