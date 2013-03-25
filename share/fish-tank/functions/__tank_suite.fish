function __tank_suite
  for func in (functions -n)
    switch $func
      case 'it_*'
        echo $func
    end
  end
end
