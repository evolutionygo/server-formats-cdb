--リチュア・シェルフィッシュ
--Gishki Mollusk
function c19959742.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc19959742(c19959742,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c19959742.condition)
	e1:SetOperation(c19959742.operation)
	c:RegisterEffect(e1)
end
function c19959742.condition(e,tp,eg,ep,ev,re,r,rp)
	return (r&REASON_EFFECT)~=0 and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
end
function c19959742.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	Duel.SortDecktop(tp,tp,3)
	if Duel.SelectOption(tp,aux.Stringc19959742(c19959742,1),aux.Stringc19959742(c19959742,2))==1 then
		Duel.MoveToDeckBottom(3,tp)
	end
end