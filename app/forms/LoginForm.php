<?php

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\Validator\Constraints as Assert;

// Trieda pre vytvorenie prihlasovacieho formulara

class LoginForm extends AbstractType
{

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('login', 'text', array(
                'label' => 'Meno',
                'attr' => array('class' => 'form-control', 'placeholder' => 'Zadajte meno')
            ))
            ->add('password', 'password', array(
                'label' => 'Heslo',
                'attr' => array('class' => 'form-control')
            ))
            ->add('Prihlásiť', 'submit', array(
                'attr' => array('class' => 'btn btn-lg btn-primary form-control')
            ));
    }

    public function getName()
    {
        return 'LoginForm';
    }
}