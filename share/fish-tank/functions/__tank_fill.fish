function __tank_fill
  for func in (functions -n)
    switch $func
      case 'it_*'
        tank_add $func
    end
  end
end
