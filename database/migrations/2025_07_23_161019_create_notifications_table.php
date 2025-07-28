<?php

use App\Models\User;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('notifications', function (Blueprint $table) {
            $table->id();
            $table->dateTime('date_envoi');
            $table->string('message');
            $table->foreignIdFor(User::class)->constrained()->onDelete('cascade');
            $table->boolean('lu')->default(false);
            $table->string('type')->default('info'); // 'info', 'warning', 'error', etc.
            $table->string('source')->nullable(); // Source of the notification, e.g., 'system', 'user', etc.
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('notifications');
    }
};
