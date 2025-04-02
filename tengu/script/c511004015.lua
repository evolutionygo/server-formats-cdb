--カタパルト・タートル (Anime)
--Catapult Turtle (Anime)
--Scripted by edo9300, rescripted by The Razgriz
function c511004015.initial_effect(c)
	--Tribute 1 monster to inflict damage to opponent
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511004015(c511004015,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1,0,EFFECT_COUNT_CODE_SINGLE)
	e1:SetCost(c511004015.cost)
	e1:SetTarget(c511004015.damtg)
	e1:SetOperation(c511004015.damop)
	c:RegisterEffect(e1)
	--Tribute 1 monster to destroy 1 Spell/Trap Card and damage owner of Tributed monster
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringc511004015(c511004015,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetTarget(c511004015.sttg)
	e2:SetOperation(c511004015.stop)
	c:RegisterEffect(e2)
	--Increase ATK, then Tribute to destroy monster and damage owner of Tributed monster
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511004015(c511004015,2))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCountLimit(1,0,EFFECT_COUNT_CODE_SINGLE)
	e3:SetTarget(c511004015.destg)
	e3:SetOperation(c511004015.desop)
	c:RegisterEffect(e3)
end
function c511004015.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,nil,1,false,nil,nil) end
	local sg=Duel.SelectReleaseGroupCost(tp,nil,1,1,false,nil,nil)
	Duel.Release(sg,REASON_COST)
	e:SetLabelObject(sg:GetFirst())
end
function c511004015.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetLabelObject():GetPreviousAttackOnField()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam/2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam/2)
end
function c511004015.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511004015.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsSpellTrap),tp,0,LOCATION_ONFIELD,1,nil) end
	local tc=e:GetLabelObject()
	local dam=tc:GetBaseAttack()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,aux.FaceupFilter(Card.IsSpellTrap),tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetTargetCard(g:GetFirst())
	Duel.SetTargetPlayer(tc:GetOwner())
	Duel.SetTargetParam(dam/2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tc:GetOwner(),dam/2)
end
function c511004015.stop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and Duel.Destroy(tc,REASON_EFFECT)>0 then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	end
end	
function c511004015.cfilter(c,tp)
	return c:IsReleasable() and c:IsFaceup() and Duel.IsExistingMatchingCard(c511004015.desfilter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack())
end
function c511004015.desfilter(c,atk)
	return c:IsFaceup() and c:GetDefense()<(atk+600)
end
function c511004015.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c511004015.cfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511004015.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local tc=g:GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,tc,1,0,600)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,1,0,1-tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,1,0,tc:GetOwner(),tc:GetBaseAttack()/2)
end
function c511004015.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	tc:UpdateAttack(600)
	if Duel.Release(tc,REASON_EFFECT)>0 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=Duel.SelectMatchingCard(tp,c511004015.desfilter,tp,0,LOCATION_MZONE,1,1,nil,tc:GetPreviousAttackOnField())
		if #sg>0 and Duel.Destroy(sg:GetFirst(),REASON_EFFECT)>0 then
			Duel.Damage(tc:GetOwner(),tc:GetBaseAttack()/2,REASON_EFFECT)
		end
	end
end