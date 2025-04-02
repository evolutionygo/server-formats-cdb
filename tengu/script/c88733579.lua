--穿孔虫
--Drill Bug
function c88733579.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc88733579(c88733579,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c88733579.condition)
	e1:SetOperation(c88733579.operation)
	c:RegisterEffect(e1)
end
c88733579.listed_names={27911549}
function c88733579.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp
end
function c88733579.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK,0,1,1,nil,27911549):GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveToDeckTop(tc)
		Duel.ConfirmDecktop(tp,1)
	end
end