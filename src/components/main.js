import React, {Component} from 'react';
import ReactMarkdown from 'react-markdown'
import './main.css';

var apiEndpoint = "https://api.github.com"
var username = 'jackbilestech'
var thisRepo = 'AMX-AV-Generic-Control'

class ReadMe extends Component{
    constructor(props){
        super(props)
        this.state = {
        }
    }
    componentDidMount (){
        fetch(`${apiEndpoint}/repos/${username}/${thisRepo}/readme`)
            .then(res => res.json())
            .then(
                (result) => {
                result.content = window.atob(result.content)
                this.setState(result);
                
                
                },
                // Note: it's important to handle errors here
                // instead of a catch() block so that we don't swallow
                // exceptions from actual bugs in components.
                (error) => {
                this.setState();
                }
            )

    }
    render () {
        return(
            <span>
                <ReactMarkdown source={this.state.content}></ReactMarkdown>
            </span>
        )
    } 
}

export default ReadMe;
