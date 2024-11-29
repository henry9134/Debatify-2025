import { Controller } from "@hotwired/stimulus";
import anime from "animejs";

export default class extends Controller {
    connect(){
        console.log("stimulus controller connected")

        const textWrapper = this.element.querySelector(".ml12");

        textWrapper.innerHTML = textWrapper.textContent.replace(
            /\S/g,
            "<span class='letter'>$&</span>"
        );

        anime
            .timeline({ loop: true })
            .add({
                targets: ".ml12 .letter",
                translateX: [40, 0],
                translateZ: 0,
                opacity: [0, 1],
                easing: "easeOutExpo",
                duration: 1200,
                delay: (el, i) => 500 + 30 * i,
            })
            .add({
                targets: ".ml12 .letter",
                translateX: [0, -30],
                opacity: [1, 0],
                easing: "easeInExpo",
                duration: 1100,
                delay: (el, i) => 100 + 30 * i,
            });
    }
}