--翡翠の蟲笛
--Jade Insect Whistle (GOAT)
function c504700168.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c504700168.target)
	e1:SetOperation(c504700168.activate)
	c:RegisterEffect(e1)
end
function c504700168.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
end
function c504700168.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringc504700168(c504700168,0))
	local g=Duel.SelectMatchingCard(1-tp,Card.IsRace,1-tp,LOCATION_DECK,0,1,1,nil,RACE_INSECT)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(1-tp)
		Duel.MoveSequence(tc,0)
		Duel.ConfirmDecktop(1-tp,1)
	else
		Duel.GoatConfirm(1-tp,LOCATION_DECK)
	end
end