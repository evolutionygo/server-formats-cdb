--ブリザード・ファルコン (Anime)
--Blizzard Falcon (Anime)
Duel.EnableUnofficialProc(PROC_STATS_CHANGED)
function c511002546.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511002546(c511002546,0))
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(c511002546)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511002546.damcon)
	e1:SetTarget(c511002546.damtg)
	e1:SetOperation(c511002546.damop)
	c:RegisterEffect(e1)
end
function c511002546.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not eg:IsContains(c) then return false end
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	return c:GetAttack()~=val
end
function c511002546.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local atk=0
	if c:GetBaseAttack()>=c:GetAttack() then
		atk=c:GetBaseAttack()-c:GetAttack()
	else
		atk=c:GetAttack()-c:GetBaseAttack()
	end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c511002546.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local atk=0
	if c:GetBaseAttack()>=c:GetAttack() then
		atk=c:GetBaseAttack()-c:GetAttack()
	else
		atk=c:GetAttack()-c:GetBaseAttack()
	end
	Duel.Damage(p,atk,REASON_EFFECT)
end