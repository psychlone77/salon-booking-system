"use client";

import React, { useState } from 'react';
import { Input, Button, Spacer } from '@nextui-org/react';

const SignupPage: React.FC = () => {
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [email, setEmail] = useState('');
    const [phoneNumber, setPhoneNumber] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        // Handle form submission logic here
        console.log({ firstName, lastName, email, password, phoneNumber });
    };

    return (
        <div className="signup-page flex flex-col items-center justify-center min-h-screen font-serif bg-gray-100">
            <h2 className="text-5xl font-bold mb-6">Sign Up</h2>
            <form onSubmit={handleSubmit} className="bg-white p-8 rounded-2xl shadow-md w-full max-w-md grid place-items-center gap-4">
                <div className='flex flex-row gap-4'>
                    <div className="w-full">
                        <Input
                            label="First Name"
                            value={firstName}
                            onChange={(e) => setFirstName(e.target.value)}
                            required
                        />
                    </div>
                    <div className="w-full">
                        <Input
                            label="Last Name"
                            value={lastName}
                            onChange={(e) => setLastName(e.target.value)}
                            required
                        />
                    </div>
                </div>
                <div className="w-full">
                    <Input
                        type="email"
                        label="Email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                    />
                </div>
                <div className="w-full">
                    <Input
                        type="tel"
                        label="Phone Number"
                        value={phoneNumber}
                        onChange={(e) => setPhoneNumber(e.target.value)}
                        required
                    />
                </div>
                <div className="w-full">
                    <Input
                        type="password"
                        label="Password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required
                    />
                </div>
                <div className="w-full">
                    <Input
                        type="password"
                        label="Confirm Password"
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        required
                    />
                </div>
                <Spacer y={1} />
                <Button className="text-lg w-44" type="submit" color="primary">
                    Sign Up
                </Button>
                <div className="w-full text-center mt-4">
                    <a href="/login" className="text-grey hover:underline">
                        Already have an account? Log in
                    </a>
                </div>
            </form>
        </div>
    );
};

export default SignupPage;