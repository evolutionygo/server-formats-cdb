--魔草 マンドラゴラ
--magical Plant Mandragola
function c7802006.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc7802006(c7802006,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c7802006.operation)
	c:RegisterEffect(e1)
end
c7802006.counter_list={COUNTER_SPELL}
function c7802006.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(COUNTER_SPELL,1)
end
function c7802006.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c7802006.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do 
		tc:AddCounter(COUNTER_SPELL,1)
	end
end