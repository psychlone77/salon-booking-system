"use client"

import React, { useState } from 'react';
import { Input, Button, Card } from '@nextui-org/react';

const LoginPage: React.FC = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');

    const handleSubmit = (event: React.FormEvent) => {
        event.preventDefault();
        // Handle login logic here
        console.log('Email:', email);
        console.log('Password:', password);
    };

    return (
        <div className="font-serif flex justify-center items-center h-screen">
            <Card className="w-80 p-5">
                <form onSubmit={handleSubmit} className="flex flex-col">
                    <div className="mb-5">Login</div>
                    <Input
                        label="Email"
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                        className="mb-4"
                    />
                    <Input
                        label="Password"
                        type="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required
                        className="mb-6"
                    />
                    <Button type="submit" className="bg-blue-500 text-white">
                        Login
                    </Button>
                </form>
            </Card>
        </div>
    );
};

export default LoginPage;