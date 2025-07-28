<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Posseder extends Model
{
    protected $fillable = ['id_niv', 'id_fil'];

    public function niveau()
    {
        return $this->belongsTo(Niveau::class);
    }

    public function etudiants()
    {
        return $this->hasMany(Etudiant::class);
    }

    public function matieres()
    {
        return $this->hasMany(Matiere::class);
    }

    public function filiere()
    {
        return $this->belongsTo(Filiere::class);
    }
}
