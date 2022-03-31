classdef interrupt_testing < handle
    %
    %   Class:
    %   interrupt_testing
    
    %{
    2020b
    UI Figure, timer then direct callback:
        Starting timer
        Button callback started
        Button callback stopped
        Stopping timer
    
    
    
    %}
    
    properties
        h_fig
        timer_button
        callback_button
        timer
    end
    
    methods
        function obj = interrupt_testing(use_guide)
            if nargin == 0
                use_guide = false;
            end
            if use_guide
                %TODO: Support figure as well ...
                obj.h_fig = figure();
                %obj.timer_button = uicontrol
            else
            
                obj.h_fig = uifigure();
                obj.timer_button = uibutton(obj.h_fig,'Text','Timer','Position',[100 100 100 50]);
                obj.callback_button = uibutton(obj.h_fig,'Text','Callback','Position',[300 100 100 50]);
                obj.timer_button.ButtonPushedFcn = @(~,~)obj.startTimer();
                obj.callback_button.ButtonPushedFcn = @(~,~)obj.buttonCallback();
            end
        end
        function startTimer(obj)
            %TODO: Make this repeat every 3 seconds (period of 3)
            obj.timer = timer(); %#ok<CPROP>
            obj.timer.TimerFcn = @(~,~)obj.timerCallback();
            start(obj.timer);
        end
        function buttonCallback(obj)
         	fprintf(2,'Button callback started\n');
            pause(5);
            fprintf(2,'Button callback stopped\n');
        end
        function timerCallback(obj)
            %Java
            %
            fprintf(2,'Starting timer\n');
            pause(5);
            fprintf(2,'Stopping timer\n');
        end
        function closeFigure(obj)
            
        end
    end
end

