# Clean this up.  Have it assume there's an install?
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require "panini"

grammar = Panini::Grammar.new


# ================
# = Nonterminals =
# ================
expression = grammar.add_nonterminal("EXPR")
term = grammar.add_nonterminal("TERM")
factor = grammar.add_nonterminal("FACT")
identifier = grammar.add_nonterminal("ID")
number = grammar.add_nonterminal("NUM")


# =============
# = Terminals =
# =============
expression.add_production([term, '+', term])
expression.add_production([term, '-', term])
expression.add_production([term])

term.add_production([factor, '*', term])
term.add_production([factor, '/', term])
term.add_production([factor])

factor.add_production([identifier])
factor.add_production([number])
factor.add_production(['(', expression, ')'])

('a'..'z').each do |v|
  identifier.add_production([v])
end

# It would be cool to have a way to create a random number.
(0..100).each do |n|
  number.add_production([n])
end


# ===============================================
# = Choose a strategy and create some sentences =
# ===============================================
deriver = Panini::DerivationStrategy::RandomDampened.new(grammar)
10.times do
  puts "#{deriver.sentence.join(' ')}"
end
