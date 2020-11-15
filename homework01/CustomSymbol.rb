class CustomSymbol
  def all_symbols
    Symbol.all_symbols
  end

  def between?(symbol, sym1, sym2)
    if sym1 > sym2
      sym1, sym2 = sym2, sym1
    end
    symbol > sym1 and symbol < sym2
  end
end

mysymbol = CustomSymbol.new()
print(mysymbol.all_symbols)
puts()
puts(mysymbol.between?(:foo, :asd, :fds))
