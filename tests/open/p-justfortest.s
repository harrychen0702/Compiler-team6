
main {
    books:seq<string> := [s1,s2,s3];
    
	alias seq<char> string;
	alias fred spud;
	tdef person { name:string, surname:string, age:int };
	tdef family { mother:person, father:person, children:seq<person> };
	return;
};
