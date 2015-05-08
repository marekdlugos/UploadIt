<?php

// Definovanie tried a funkcii pre odovzdavanie zadani

use Symfony\Component\Validator\Mapping\ClassMetadata;
use Symfony\Component\Validator\Constraints as Assert;

class Zadanie
{
    protected $id;
    protected $nazov;
    protected $triedaId;
    protected $pouzivatelId;
    protected $predmetId;
    protected $stav;
    protected $casUzatvorenia;
    
    public function __construct() {
        $this->stav = 1;
    }
    
    public function getId() {
        return $this->id;
    }

    public function getNazov() {
        return $this->nazov;
    }

    public function getTriedaId() {
        return $this->triedaId;
    }

    public function getPouzivatelId() {
        return $this->pouzivatelId;
    }

    public function getPredmetId() {
        return $this->predmetId;
    }

    public function getStav() {
        return $this->stav;
    }

    public function getCasUzatvorenia() {
        return $this->casUzatvorenia;
    }

    public function setId($id) {
        $this->id = $id;
    }

    public function setNazov($nazov) {
        $this->nazov = $nazov;
    }

    public function setTriedaId($triedaId) {
        $this->triedaId = $triedaId;
    }

    public function setPouzivatelId($pouzivatelId) {
        $this->pouzivatelId = $pouzivatelId;
    }

    public function setPredmetId($predmetId) {
        $this->predmetId = $predmetId;
    }

    public function setStav($stav) {
        $this->stav = $stav;
    }
    
    public function setPoUzavierke($stav)
    {
        $this->stav = $stav === true ? 2 : 1; 
    }
    
    public function getPoUzavierke()
    {
        return $this->stav == 2; 
    }

    public function setCasUzatvorenia($casUzatvorenia) {
        $this->casUzatvorenia = $casUzatvorenia;
    }
    
    public static function loadValidatorMetadata(ClassMetadata $metadata)
    {
        $metadata->addPropertyConstraint('nazov', new Assert\NotBlank());
    }
}