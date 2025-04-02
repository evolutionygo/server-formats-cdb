--Ｓｐ－ジ・エンド・オブ・ストーム (Anime)
--Speed Spell - The End of the Storm (Anime)
--Scripted by Larry126
function c513000147.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c513000147.condition)
	e1:SetTarget(c513000147.target)
	e1:SetOperation(c513000147.activate)
	c:RegisterEffect(e1)
end
function c513000147.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_FZONE,0)
	return tc and tc:GetCounter(0x91)>=10
end
function c513000147.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,#g*300)
end
function c513000147.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	Duel.Damage(tp,og:FilterCount(Card.IsPreviousControler,nil,tp)*300,REASON_EFFECT,true)
	Duel.Damage(1-tp,og:FilterCount(Card.IsPreviousControler,nil,1-tp)*300,REASON_EFFECT,true)
	Duel.RDComplete()
end