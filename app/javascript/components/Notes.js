import React, { Component, useState } from 'react';

import { NavMenu } from './NavMenu';

export class Notes extends Component {
    static displayName = Notes.name;

    constructor(props) {
        super(props);
        this.state = {
            tumblr: []
        };
    }

    componentDidMount() {

        this.loadBlogs();

    }

    loadBlogs() {

        fetch('/tumblr/links')
            .then((res) => {
                return res.json();
            }).then((data) => {
                this.setState({ tumblr: data });
            });
    }

    render() {

        return (

            <div id="content">
                <div></div>
                <div>
                    <div>
                        <NavMenu />
                        <h1 className="cc-notes">Collected articles and links</h1>
                        <div className="cc-divide cc-notes-divide">
                            {this.state.tumblr.map((post) => (
                                <div className="p-2">
                                    <a href={post.link}>{post.title}</a>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            </div>

        );
    }
}
