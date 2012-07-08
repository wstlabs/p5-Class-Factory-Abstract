# NAME

Class::Factory::Abstract - A simple abstract factory class

# SYNOPSIS

The module itself is an abstract class, meaning by itself it doesn't do anything -- you need to create an extension class, which in general need only provide one method, <code>resolve()</code>:

```
  package My::Widget::Factory;
  use parent 'Class::Factory::Abstract';

  # provide a custom resolver, that simple takes a string ($desc), and perhaps 
  # some optional args, and provides a package from which to instantiate new widgets.
  sub resolve  {
    my ($self, $desc, @opts) = @_;
    my $package = ...
    return $package
  }
```

Then down in your app:

```
  my $factory = My::Widget::Factory->new();
  my $widget = $factory->instantiate('widgetName', \%options);
```

# DESCRIPTION 

This class arose out of some observations about the existing CPAN module <code>Class::Factory</code>.  In particular, its interface seemed to be basically broken, in that the "new" method was hijacked as an action verb (to instantiate objects of the selected type), rather than being a kept constructor for the factory itself (which is the only sensible use of the <code>new()</code> method).

This class restores <code>new()</code> as the actual factory constructor, and provides a new method <code>instantiate()</code> which cranks out actual class instances, provided an implementation of the abstract method <code>resolve()</code> is available (see USAGE, below). 


# USAGE 

The basic idea is that you only need to provide a suitable "args-to-package" mapping, via the abstract method <code>resolve</code> -- the abstract parent class takes care of the actual legwork of instantiating the desired instance, i.e. loading the desired package after doing a few reasonable checks that the package name is valid, and is indeed available for loading. 

The release contains one concrete implementation, <code>Class::Factory::Dict</code>, which illustrates an example of a simple <code>resolve()</code> implementation based on a simple dictionary (i.e., hash-based) lookup. 

# CAVEATS

Note that in general class factories are singletonized throughout the application, which is something this Factory object (being just a regular object) doesn't do by itself for you in any way (in the interested of maintaining overall simplicity of design).  However, in general it's quite easy to singletonize arbitrary objects in Perl; here's an example of how to do this in Perl 5.10 or greater:

```
  package My::Widget::Utils;
  use My::Widget::Factory;
  
  {
     my $factory;
     sub get_widget_factory  {
        $factory //= My::Widget::Factory->new
     }
  }
```

Then down in your application:
```
  my $widget = get_widget_factory()->instantiate('widgetName', \%options);
```

# LINKS
* https://metacpan.org/release/Class-Factory
* https://en.wikipedia.org/wiki/Abstract_factory_pattern

