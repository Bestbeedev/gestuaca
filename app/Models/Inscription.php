<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Inscription extends Model
{
    protected $fillable = ['id_etudiant', 'id_annee'];

    public function etudiant()
    {
        return $this->belongsTo(Etudiant::class);
    }

    public function annee()
    {
        return $this->belongsTo(Annee::class);
    }
}
