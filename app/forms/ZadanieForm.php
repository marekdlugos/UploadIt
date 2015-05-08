<?php

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\Validator\Constraints as Assert;

// Trieda pre vytvorenie formulara na odovzdanie

class ZadanieForm extends AbstractType
{
    /** @var TriedyRepository */
    protected $triedyRepository;
    
    /** @var PredmetyRepository */
    protected $predmetyRepository;
    
    public function __construct(TriedyRepository $triedyRepository, PredmetyRepository $predmetyRepository)
    {
        $this->triedyRepository = $triedyRepository;
        $this->predmetyRepository = $predmetyRepository;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('nazov', 'text', array(
                'label' => 'Názov termínu',
                'attr' => array('class' => 'form-control', 'placeholder' => 'Zadajte názov termínu')
            ))
            ->add('predmet_id', 'choice', array(
                'choices' => $this->predmetyRepository->getList(),
                'label' => 'Predmet',
                'attr' => array('class' => 'form-control')
            ))
            ->add('cas_uzatvorenia', 'datetime', array(
                'label' => 'Trva do',
                'data' => new DateTime,
            ))
            ->add('trieda_id', 'choice', array(
                'choices' => $this->triedyRepository->getList(),
                'label' => 'Trieda',
                'attr' => array('class' => 'form-control')
            ))
            ->add('po_uzavierke', 'checkbox', array(
                'required' => false,
                'label' => 'Možné odovzdať aj po termíne'
            ))
            ->add('Vytvoriť termín', 'submit', array(
                'attr' => array('class' => 'btn btn-primary form-control')
            ));
    }
    
    public function getName()
    {
        return 'ZadanieForm';
    }
}