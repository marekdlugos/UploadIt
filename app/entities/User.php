<?php

// Definovanie funkcii a tried pri prihlasovani uzivatela

class User
{

	protected $login;
	protected $password;

	public function getLogin() {
		return $this->login;
	}

	public function setLogin($login) {
		$this->login = $login;
		return $this;
	}

	public function getPassword() {
		return $this->password;
	}

	public function setPassword($password) {
		$this->password = $password;
		return $this;
	}

}