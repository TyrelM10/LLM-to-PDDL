#!/usr/bin/env python3
""" A PDDL parser for Python.

This module implements a simple parser for the Planning Domain
Definition Language (PDDL), using the pyparsing library.

It implements the BNF of PDDL 3.1 as described in:

   Daniel L. Kovacs: Complete BNF description of PDDL 3.1 (completely
   corrected), 2011.

The order of grammar rules has been changed to account for
dependencies between the rules (if a non-terminal N is used in the
body of a rule, the rule for N must precede it) and to minimize the
backtracking.

Other corrections and adaptations have been made where indicated.

It is assumed that all keywords and identifiers are caseless (so
":strips" is identified with ":STRIPS", and "move-block" with
"MOVE-BLOCK").

The two functions for parsing domain and problem files return an
abstract syntax tree (AST) in the form of a dictionary.
"""

__author__  = "Jens Classen"
__license__ = "GPLv2"

from pyparsing import *

################################################################################
# File Parsing
################################################################################

def parse_pddl_domain_from_file(file):
    """ Returns the AST for the given PDDL domain file as a dictionary. """
    return PDDL_BNF()['domain'].parse_file(file).as_dict()

def parse_pddl_problem_from_file(file):
    """ Returns the AST for the given PDDL problem file as a dictionary. """
    return PDDL_BNF()['problem'].parse_file(file).as_dict()

################################################################################
# PDDL BNF
################################################################################

pddl_bnf = None

def PDDL_BNF():
    global pddl_bnf
    
    if pddl_bnf is None:

        # Keywords
        DEFINE = CaselessKeyword("define")
        DOMAIN = CaselessKeyword("domain")
        PROBLEM = CaselessKeyword("problem")
        
        REQUIREMENTS = CaselessKeyword(":requirements")
        TYPES = CaselessKeyword(":types")
        CONSTANTS = CaselessKeyword(":constants")
        PREDICATES = CaselessKeyword(":predicates")
        FUNCTIONS = CaselessKeyword(":functions")
        CONSTRAINTS = CaselessKeyword(":constraints")
        ACTION = CaselessKeyword(":action")
        DURATIVE_ACTION = CaselessKeyword(":durative-action")
        PARAMETERS = CaselessKeyword(":parameters")
        PRECONDITION = CaselessKeyword(":precondition")
        EFFECT = CaselessKeyword(":effect")
        DURATION = CaselessKeyword(":duration")
        CONDITION = CaselessKeyword(":condition")
        DERIVED = CaselessKeyword(":derived")
        OBJECTS = CaselessKeyword(":objects")
        INIT = CaselessKeyword(":init")
        GOAL = CaselessKeyword(":goal")
        METRIC = CaselessKeyword(":metric")
        LENGTH = CaselessKeyword(":length")
        SERIAL = CaselessKeyword(":serial")
        PARALLEL = CaselessKeyword(":parallel")
        CDOMAIN = CaselessKeyword(":domain")
        
        AND = CaselessKeyword("and")
        OR = CaselessKeyword("or")
        NOT = CaselessKeyword("not")
        IMPLY = CaselessKeyword("imply")
        EXISTS = CaselessKeyword("exists")
        FORALL = CaselessKeyword("forall")
        WHEN = CaselessKeyword("when")
        
        ALWAYS = CaselessKeyword("always")
        SOMETIME = CaselessKeyword("sometime")
        WITHIN = CaselessKeyword("within")
        AT_MOST_ONCE = CaselessKeyword("at-most-once")
        SOMETIME_AFTER = CaselessKeyword("sometime-after")
        SOMETIME_BEFORE = CaselessKeyword("sometime-before")
        ALWAYS_WITHIN = CaselessKeyword("always-within")
        HOLD_DURING = CaselessKeyword("hold-during")
        HOLD_AFTER = CaselessKeyword("hold-after")
        
        OBJECT = CaselessKeyword("object")
        NUMBER = CaselessKeyword("number")
        EITHER = CaselessKeyword("either")
        
        ASSIGN = CaselessKeyword("assign")
        SCALE_UP = CaselessKeyword("scale-up")
        SCALE_DOWN = CaselessKeyword("scale-down")
        INCREASE = CaselessKeyword("increase")
        DECREASE = CaselessKeyword("decrease")
        UNDEFINED = CaselessKeyword("undefined")
        
        MAXIMIZE = CaselessKeyword("maximize")
        MINIMIZE = CaselessKeyword("minimize")
        IS_VIOLATED = CaselessKeyword("is-violated")
        PREFERENCE = CaselessKeyword("preference")
        
        START = CaselessKeyword("start")
        END = CaselessKeyword("end")
        OVER = CaselessKeyword("over")
        AT = CaselessKeyword("at")
        ALL = CaselessKeyword("all")
        
        # Special Identifiers
        VAR_DURATION = CaselessLiteral("?duration")
        SHARP_T = CaselessLiteral("#t")
        TOTAL_TIME = CaselessLiteral("total-time")
        
        # Parentheses
        LP = Literal("(").suppress()
        RP = Literal(")").suppress()
        
        # Punctuation
        DASH = Literal("-")
        UNDERSCORE = Literal("_")
        POINT = Literal(".")
        
        # Arithmetic Operators
        EQUALS = Literal("=")
        LT = Literal("<")
        GT = Literal(">")
        LTE = Literal("<=")
        GTE = Literal(">=")
        MINUS = Literal("-")
        PLUS = Literal("+")
        MUL = Literal("*")
        DIV = Literal("/")
        
        # Comments
        comment = Literal(";") + restOfLine
        
        digit = Char(nums)
        letter = Char(alphas)
        
        any_char = letter | digit | DASH | UNDERSCORE
        name = Combine(letter + ZeroOrMore(any_char)).set_parse_action(pyparsing_common.downcase_tokens)
        
        require_key = one_of([
            ":strips",
            ":typing",
            ":negative-preconditions",
            ":disjunctive-preconditions",
            ":equality",
            ":existential-preconditions",
            ":universal-preconditions",
            ":quantified-preconditions",
            ":existential-preconditions",
            ":universal-preconditions",
            ":conditional-effects",
            ":fluents",
            ":numeric-fluents",
            ":object-fluents",
            ":adl",
            ":durative-actions",
            ":duration-inequalities",
            ":continuous-effects",
            ":derived-predicates",
            ":timed-initial-literals",
            ":preferences",
            ":constraints",
            ":action-costs"
        ], caseless=True)
        
        require_def = Dict(Group(LP + REQUIREMENTS + OneOrMore(require_key) + RP))
        
        primitive_type = name | OBJECT
        
        type = \
            Group(LP + EITHER + OneOrMore(primitive_type) + RP) | \
            primitive_type
        
        typed_list_name = Forward()
        typed_list_name <<= \
            Group(OneOrMore(name) + DASH + type) + typed_list_name | \
            ZeroOrMore(name)
        
        variable = Combine(Literal("?") + name)
        
        typed_list_variable = Forward()
        typed_list_variable <<= \
            Group(OneOrMore(variable) + DASH + type) + typed_list_variable | \
            ZeroOrMore(variable)
        
        types_def = Dict(Group(LP + TYPES + typed_list_name + RP))
        
        constants_def = Dict(Group(LP + CONSTANTS + typed_list_name + RP))
        
        predicate = name
        
        atomic_formula_skeleton = Group(LP + predicate + typed_list_variable + RP)
        
        predicates_def = Dict(Group(LP + PREDICATES + OneOrMore(atomic_formula_skeleton) + RP))
        
        function_symbol = name
        
        atomic_function_skeleton = Group(LP + function_symbol + typed_list_variable + RP)
        
        decimal = POINT + OneOrMore(digit)
        
        number = Combine(OneOrMore(digit) + Opt(decimal))
        
        function_type = type | NUMBER
        
        function_typed_list_afs = Forward()
        function_typed_list_afs <<= \
            Group(OneOrMore(atomic_function_skeleton) + DASH + function_type) + function_typed_list_afs | \
            OneOrMore(atomic_function_skeleton)
        
        functions_def = Dict(Group(LP + FUNCTIONS + function_typed_list_afs + RP))
        
        term = Forward()
        function_term = Forward()
        
        term <<= name | variable | function_term
        function_term <<= Group(LP + function_symbol + ZeroOrMore(term) + RP)
        
        atomic_formula_term = \
            Group(LP + predicate + ZeroOrMore(term) + RP) | \
            Group(LP + EQUALS + term + term + RP)
        
        literal_term = \
            Group(LP + NOT + atomic_formula_term + RP) | \
            atomic_formula_term
        
        binary_comp = GTE | LTE | GT | LT | EQUALS
        
        f_head = Group(LP + function_symbol + ZeroOrMore(term) + RP) | function_symbol
        
        multi_op = MUL | PLUS
        
        binary_op = multi_op | MINUS | DIV
        
        f_exp = Forward()
        f_exp <<= \
            number | \
            Group(LP + binary_op + f_exp + f_exp + RP) | \
            Group(LP + multi_op + f_exp + OneOrMore(f_exp) + RP)  | \
            Group(LP + MINUS + f_exp + RP) | \
            f_head
        
        f_comp = Group(LP + binary_comp + f_exp + f_exp + RP)

        gd = Forward()
        gd <<= \
            atomic_formula_term | \
            literal_term | \
            Group(LP + AND + ZeroOrMore(gd) + RP) | \
            Group(LP + OR + ZeroOrMore(gd) + RP) | \
            Group(LP + NOT + gd + RP) | \
            Group(LP + IMPLY + gd + gd + RP) | \
            Group(LP + EXISTS + Group(LP + typed_list_variable + RP) + gd + RP) | \
            Group(LP + FORALL + Group(LP + typed_list_variable + RP) + gd + RP) | \
            f_comp

        # Using version with nested temporal operators
        con_gd = Forward()
        con2_gd = Forward()
        con_gd <<= \
            Group(LP + AND + ZeroOrMore(con_gd) + RP) | \
            Group(LP + FORALL + Group(LP + typed_list_variable + RP) + con_gd + RP) | \
            Group(LP + AT + END + gd + RP) | \
            Group(LP + ALWAYS + con2_gd + RP) | \
            Group(LP + SOMETIME + con2_gd + RP) | \
            Group(LP + WITHIN + number + con2_gd + RP) | \
            Group(LP + AT_MOST_ONCE + con2_gd + RP) | \
            Group(LP + SOMETIME_AFTER + con2_gd + con2_gd + RP) | \
            Group(LP + SOMETIME_BEFORE + con2_gd + con2_gd + RP) | \
            Group(LP + ALWAYS_WITHIN + number + con2_gd + con2_gd + RP) | \
            Group(LP + HOLD_DURING + number + number + con2_gd + RP) | \
            Group(LP + HOLD_AFTER + number + con2_gd + RP)
        con2_gd <<= con_gd | gd
        
        constraints = Dict(Group(LP + CONSTRAINTS + con_gd + RP))
        
        action_symbol = name
        
        pref_name = name
        
        pref_gd = \
            Group(LP + PREFERENCE + Opt(pref_name) + gd + RP) | \
            gd
        
        pre_gd = Forward()
        pre_gd <<= \
            pref_gd | \
            Group(LP + AND + ZeroOrMore(pre_gd) + RP) | \
            Group(LP + FORALL + Group(LP + typed_list_variable + RP) + pre_gd + RP)
        
        pre_gd_or_empty = Group(LP + RP) | pre_gd
        
        assign_op = ASSIGN | SCALE_UP | SCALE_DOWN | INCREASE | DECREASE
        
        p_effect = \
            Group(LP + NOT + atomic_formula_term + RP) | \
            atomic_formula_term | \
            Group(LP + assign_op + f_head + f_exp + RP) | \
            Group(LP + ASSIGN + function_term + term + RP) | \
            Group(LP + ASSIGN + function_term + UNDEFINED + RP)
        
        cond_effect = \
            Group(LP + AND + ZeroOrMore(p_effect) + RP) | \
            p_effect
        
        effect = Forward()
        c_effect = Forward()
        
        c_effect <<= \
            Group(LP + FORALL + Group(LP + typed_list_variable + RP) + effect + RP) | \
            Group(LP + WHEN + gd + cond_effect + RP) | \
            p_effect
        
        effect <<= \
            Group(LP + AND + ZeroOrMore(c_effect) + RP) | \
            c_effect
        
        effect_or_empty = Group(LP + RP) | effect
        
        action_def_body = \
            Opt(Dict(Group(PRECONDITION + pre_gd_or_empty))) + \
            Opt(Dict(Group(EFFECT + effect_or_empty)))
        
        action_def = Group(
            LP + ACTION + action_symbol("name") + \
            Dict(Group(PARAMETERS + LP + typed_list_variable + RP)) + \
            action_def_body + RP
        )
        
        da_symbol = name
        
        d_op = LTE | GTE | EQUALS
        
        d_value = number | f_exp
        
        time_specifier = START | END
        
        simple_duration_constraint = Forward()
        simple_duration_constraint <<= \
            Group(LP + d_op + VAR_DURATION + d_value + RP) | \
            Group(LP + AT + time_specifier + simple_duration_constraint + RP)
        
        duration_constraint = Group(LP + AND + OneOrMore(simple_duration_constraint) + RP) | \
            LP + RP | \
            simple_duration_constraint
        
        interval = ALL
        
        timed_gd = Group(LP + AT + time_specifier + gd + RP) | \
            Group(LP + OVER + interval + gd + RP)
        
        pref_timed_gd = timed_gd | \
            Group(LP + PREFERENCE + Opt(pref_name) + timed_gd + RP)
        
        da_gd = Forward()
        da_gd <<= pref_timed_gd | \
            Group(LP + AND + ZeroOrMore(da_gd) + RP) | \
            Group(LP + FORALL + Group(LP + typed_list_variable + RP) + da_gd + RP)
        
        da_gd_or_empty = Group(LP + RP) | da_gd
        
        f_exp_da = Forward()
        f_exp_da <<= \
            Group(LP + binary_op + f_exp_da + f_exp_da + RP) | \
            Group(LP + multi_op + f_exp_da + OneOrMore(f_exp_da) + RP) | \
            Group(LP + MINUS + f_exp_da + RP) | \
            VAR_DURATION | \
            f_exp
        
        f_assign_da = Group(LP + assign_op + f_head + f_exp_da + RP)
        
        assign_op_t = INCREASE | DECREASE
        
        f_exp_t = \
            Group(LP + MUL + f_exp + SHARP_T + RP) | \
            Group(LP + MUL + SHARP_T + f_exp + RP) | \
            SHARP_T
        
        timed_effect = \
            Group(LP + AT + time_specifier + cond_effect + RP) | \
            Group(LP + AT + time_specifier + f_assign_da + RP) | \
            Group(LP + assign_op_t + f_head + f_exp_t + RP)
        
        da_effect = Forward()
        da_effect <<= \
            Group(LP + AND + ZeroOrMore(da_effect) + RP) | \
            timed_effect | \
            Group(LP + FORALL + Group(LP + typed_list_variable + RP) + da_effect + RP) | \
            Group(LP + WHEN + da_gd + timed_effect + RP)
        
        da_effect_or_empty = Group(LP + RP) | da_effect
        
        da_def_body = Dict(Group(DURATION + duration_constraint)) + \
            Dict(Group(CONDITION + da_gd_or_empty)) + \
            Dict(Group(EFFECT + da_effect_or_empty))

            
        durative_action_def = Group(LP + DURATIVE_ACTION + da_symbol("name") + \
            Dict(Group(PARAMETERS + LP + typed_list_variable + RP)) + \
            da_def_body + RP)
        
        derived_def = Group(LP + DERIVED + atomic_formula_skeleton + gd + RP)
        
        structure_def = action_def | durative_action_def | derived_def
        
        domain = LP + DEFINE + LP + DOMAIN.suppress() + name("name") + RP + \
            Opt(require_def) + \
            Opt(types_def) + \
            Opt(constants_def) + \
            Opt(predicates_def) + \
            Opt(functions_def) + \
            Opt(constraints) + \
            ZeroOrMore(structure_def)("structures") + RP
        domain.ignore(comment)
        
        object_declaration = Dict(Group(LP + OBJECTS + typed_list_name + RP))
        
        basic_function_term = \
            function_symbol | \
            Group(LP + function_symbol + ZeroOrMore(name) + RP)
        
        atomic_formula_name = \
            Group(LP + predicate + ZeroOrMore(name) + RP) | \
            Group(LP + EQUALS + name + name + RP)
        
        literal_name = \
            Group(LP + NOT + atomic_formula_name + RP) | \
            atomic_formula_name
        
        init_el = \
            literal_name | \
            Group(LP + AT + number + literal_name + RP) | \
            Group(LP + EQUALS + basic_function_term + number + RP) | \
            Group(LP + EQUALS + basic_function_term + name + RP)
        
        init = Dict(Group(LP + INIT + ZeroOrMore(init_el) + RP))
        
        goal = Dict(Group(LP + GOAL + pre_gd + RP))
        
        pref_con_gd = Forward()
        pref_con_gd <<= \
            Group(LP + AND + ZeroOrMore(pref_con_gd) + RP) | \
            Group(LP + FORALL + LP + typed_list_variable + RP + pref_con_gd + RP) | \
            Group(LP + PREFERENCE + Opt(pref_name) + con_gd + RP) | \
            con_gd
        
        constraints_prob = Dict(Group(LP + CONSTRAINTS + pref_con_gd + RP))
        
        optimization = MINIMIZE | MAXIMIZE
        
        metric_f_exp = Forward()
        metric_f_exp <<= \
            Group(LP + binary_op + metric_f_exp + metric_f_exp + RP) | \
            Group(LP + multi_op + metric_f_exp + OneOrMore(metric_f_exp) + RP) | \
            Group(LP + MINUS + metric_f_exp + RP) | \
            number | \
            Group(LP + function_symbol + ZeroOrMore(name) + RP) | \
            function_symbol | \
            TOTAL_TIME | \
            Group(LP + IS_VIOLATED + pref_name + RP)
        
        metric_spec = Dict(Group(LP + METRIC + optimization + metric_f_exp + RP))
        
        integer = OneOrMore(digit) # was missing in BNF
        
        length_spec = Dict(Group(LP + LENGTH + \
                                 Opt(Dict(Group(LP + SERIAL + integer + RP))) + \
                                 Opt(Dict(Group(LP + PARALLEL + integer + RP))) + RP))
        
        problem = LP + DEFINE.suppress() + LP + PROBLEM.suppress() + name("name") + RP + \
            Group(LP + CDOMAIN + name + RP) + \
            Opt(require_def) + \
            Opt(object_declaration) + \
            init + \
            goal + \
            Opt(constraints_prob) + \
            Opt(metric_spec) + \
            Opt(length_spec)
        problem.ignore(comment)

        pddl_bnf = {'domain': domain, 'problem': problem}

    return pddl_bnf

################################################################################
# Testing
################################################################################

import pytest
import pprint
import os

# example_domains = [filename for filename in os.listdir("examples") if "domain" in filename]
# example_problems = [filename for filename in os.listdir("examples") if "problem" in filename]

# @pytest.mark.parametrize("domain_file", example_domains)
def test_parse_domain(domain_file):
    # print(f"Parsing Domain {domain_file}")
    dom = parse_pddl_domain_from_file(domain_file)
    # pprint.pprint(dom)
    return dom

# @pytest.mark.parametrize("problem_file", example_problems)
# def test_parse_problem(problem_file):
#     print(f"Parsing Problem {problem_file}")
#     pro = parse_pddl_problem_from_file("examples/" + problem_file)
#     pprint.pprint(pro)
