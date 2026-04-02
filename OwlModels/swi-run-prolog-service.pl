% start Prolog Service
:- style_check(-singleton).
:- consult('swi-standard-declarations.pl').


load_pl_file(X) :- consult(X).
unload_pl_file(X) :- unload_file(X).

load_rdf_file(X) :- rdf_load(X).
unload_rdf_file(X) :- rdf_unload(X).

load_into_db(X) :- assertz(X).
load_into_db_beginning(X) :- asserta(X).

retract_all(X) :- retractall(X).


retract_once(X) :- once(retract(X)).


holds(P,S,O) :- rdf(S,P,O).


pred_defined(Pred) :-  
    findall(X,(predicate_property(X1,visible),term_to_atom(X1,X)),XL),
    member(E,XL),
    concat(Pred,'(',PredStr),
    sub_string(E,0,L,A,PredStr), !.


createUnittedQuantity(V, U, BID) :- rdf_bnode(BID), 
    rdf_assert(BID, 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type', 'http://sadl.org/sadlimplicitmodel#UnittedQuantity'),
    rdf_assert(BID, 'http://sadl.org/sadlimplicitmodel#value', literal(type('http://www.w3.org/2001/XMLSchema#decimal', V))), 
    rdf_assert(BID, 'http://sadl.org/sadlimplicitmodel#unit', literal(type('http://www.w3.org/2001/XMLSchema#string', U))).


assignNewUQ(S, P, V, U) :- createUnittedQuantity(V,U,BID), rdf_assert(S, P, BID).


combineUnits(Op, U1, U2, Uout) :- string_concat(U1, Op, Inter), string_concat(Inter, U2, Uout).


:- consult('swi-predicate-signatures.pl').


:- consult('swi-custom-predicates.pl').


%%%%%%%%%%%%%%%
% start service
%%%%%%%%%%%%%%%
:- consult('swi-prolog-service.pl').
:- query:port_number(X), server(X), !.
